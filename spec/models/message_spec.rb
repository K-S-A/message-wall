require 'rails_helper'

RSpec.describe Message, :model do
  let(:valid_user) { FactoryGirl.create(:user) }
  let(:valid_comment) { FactoryGirl.create(:comment, user: valid_user) }
  let(:child_comment) { FactoryGirl.create(:comment, parent_id: valid_comment.id) }

  it { expect(subject).to belong_to(:user) }
  it { expect(subject).to validate_presence_of(:body) }
  it { expect(subject).to validate_presence_of(:user) }
  it { expect(valid_comment).to validate_uniqueness_of(:body).case_insensitive }
  it { expect(subject).to validate_length_of(:body).is_at_least(1).is_at_most(200) }

  context '#comments' do
    it 'should return Hash' do
      expect(subject.comments).to be_kind_of(Hash)
    end

    it 'should return empty hash if there is no comments' do
      expect(valid_comment.comments).to be_empty
    end

    it 'should return hash with length equivalent to comments count' do
      expect { child_comment }.to change { valid_comment.comments.length }.from(0).to(1)
    end
  end

  context '#post?' do
    context 'if message do not have parent_id' do
      it { expect(valid_comment.post?).to be_truthy }
    end

    context 'if message do have parent_id' do
      it { expect(child_comment.post?).to be_falsey }
    end
  end

  context '#parent' do
    it 'should return instance of Message class' do
      expect(child_comment.parent).to be_kind_of(Message)
    end

    it 'should return direct parent of self' do
      expect(child_comment.parent).to eq(valid_comment)
    end

    it 'should raise error if there is no parent message' do
      expect { valid_comment.parent }.to raise_error
    end
  end

  context '#datestamp' do
    it 'should return string that matches //' do
      expect(valid_comment.datestamp).to match(/\d{2} \w{3} \d{4}/)
    end
  end
end
