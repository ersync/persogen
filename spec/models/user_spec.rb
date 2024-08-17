require 'rails_helper'

RSpec.shared_examples 'invalid password complexity' do |missing, password|
  it "is invalid when missing #{missing}" do
    user.password = user.password_confirmation = password
    expect(user).to be_invalid
    expect(user.errors[:password]).to include("must include at least one #{missing}")
  end
end

RSpec.describe User, type: :model do
  subject(:user) { build(:user, valid_attributes) }

  let(:valid_attributes) do
    {
      email: 'test@example.com',
      password: 'ValidPass1!',
      password_confirmation: 'ValidPass1!'
    }
  end

  describe 'Validations' do
    describe 'Email validations' do
      it { is_expected.to be_valid }

      context 'when email is nil' do
        it 'is invalid and adds the appropriate error message' do
          user.email = nil
          expect(user).to be_invalid
          expect(user.errors[:email]).to include("can't be blank")
        end
      end

      context 'when email is not unique' do
        it 'is invalid and adds the appropriate error message' do
          create(:user, email: user.email)
          expect(user).to be_invalid
          expect(user.errors[:email]).to include('has already been taken')
        end
      end

      context 'with an invalid email format' do
        it 'is invalid and adds the appropriate error message' do
          user.email = 'invalid-email'
          expect(user).to be_invalid
          expect(user.errors[:email]).to include('is invalid')
        end
      end

      context 'when email is at maximum length' do
        it 'is valid' do
          user.email = ('a' * 243) + '@example.com'
          expect(user).to be_valid
        end
      end

      context 'when email contains special characters' do
        it 'is valid with allowed special characters' do
          user.email = 'user+tag@example.com'
          expect(user).to be_valid
        end
      end
    end

    describe 'Password validations' do
      context 'when password is nil' do
        it 'is invalid and adds the appropriate error message' do
          user.password = nil
          expect(user).to be_invalid
          expect(user.errors[:password]).to include("can't be blank")
        end
      end

      context 'when password contains non-ASCII characters' do
        it 'is valid' do
          user.password = user.password_confirmation = 'ValidPass1!£'
          expect(user).to be_valid
        end
      end

      context 'when password is too short' do
        it 'is invalid and adds the appropriate error message' do
          user.password = user.password_confirmation = '12345'
          expect(user).to be_invalid
          expect(user.errors[:password]).to include('is too short (minimum is 6 characters)')
        end
      end

      context 'when password lacks complexity' do
        it_behaves_like 'invalid password complexity', 'uppercase letter', 'password123!'
        it_behaves_like 'invalid password complexity', 'lowercase letter', 'PASSWORD123!'
        it_behaves_like 'invalid password complexity', 'digit', 'Password!'
        it_behaves_like 'invalid password complexity', 'special character', 'Password123'
      end
    end
  end

  describe 'User Operations' do
    describe 'Creating a new user' do
      context 'with valid attributes' do
        it 'saves successfully' do
          expect { user.save }.to change(User, :count).by(1)
        end
      end

      context 'with invalid attributes' do
        it 'fails to save' do
          user.email = 'invalid'
          expect { user.save }.not_to change(User, :count)
        end
      end
    end

    describe 'Updating a user' do
      let!(:existing_user) { create(:user) }

      describe 'Updating email' do
        context 'without the current password' do
          it 'fails to update' do
            expect(existing_user.update(email: 'new@example.com')).to be false
            expect(existing_user.errors[:current_password]).to include("can't be blank")
          end
        end

        context 'with incorrect current password' do
          it 'fails to update' do
            expect(existing_user.update(email: 'new@example.com', current_password: 'wrongpassword')).to be false
            expect(existing_user.errors[:current_password]).to include('is invalid')
          end
        end

        context 'with correct current password' do
          it 'successfully updates' do
            expect(existing_user.update(email: 'new@example.com', current_password: existing_user.password)).to be true
            expect(existing_user.reload.email).to eq('new@example.com')
          end
        end
      end

      describe 'Updating name' do
        it 'updates without requiring the current password' do
          expect(existing_user.update(first_name: 'New Name')).to be true
          expect(existing_user.reload.first_name).to eq('New Name')
        end
      end

      describe 'Updating password' do
        context 'with correct current password' do
          it 'successfully updates to a valid new password' do
            new_password = 'NewPassword123!'
            expect(existing_user.update(password: new_password, password_confirmation: new_password,
                                        current_password: existing_user.password)).to be true
            expect(existing_user.reload.valid_password?(new_password)).to be true
          end
        end

        context 'with weak new password' do
          it 'fails to update' do
            expect(existing_user.update(password: 'weak', password_confirmation: 'weak',
                                        current_password: existing_user.password)).to be false
            expect(existing_user.errors[:password]).to include('is too short (minimum is 6 characters)')
          end
        end
      end
    end
  end
end
