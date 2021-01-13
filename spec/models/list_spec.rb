# frozen_string_literal: true

require 'rails_helper'

RSpec.describe List, type: :model do

  describe 'バリデーション' do

    context 'リストネームとuser_idがある場合' do
      it 'valid' do
        expect(create(:list)).to be_valid
      end
    end

    context 'リストネームがない場合' do
      it 'invalid' do
        expect(create(:list)).to be_valid
      end
    end

    context 'リストネームが50字の場合' do
      it 'valid' do
        list = create(:list, list_name: 'a' * 50)
        expect(list).to be_valid
      end
    end

    context 'リストネームが51字の場合' do
      it 'invalid' do
        list = build(:list, list_name: 'a' * 51)
        list.valid?
        expect(list.errors.of_kind?(:list_name, :too_long)).to be_truthy
      end
    end

    context 'リストコメントが500字の場合' do
      it 'valid' do
        list = create(:list, list_comment: 'a' * 500)
        expect(list).to be_valid
      end
    end

    context 'リストコメントが501字の場合' do
      it 'invalid' do
        list = build(:list, list_comment: 'a' * 501)
        list.valid?
        expect(list.errors.of_kind?(:list_comment, :too_long)).to be_truthy
      end
    end
  end
end
