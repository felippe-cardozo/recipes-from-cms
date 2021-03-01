# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Web::Helpers::RecipesPagination do
  describe '#previous_page' do
    context 'when skip is zero' do
      it 'returns nil' do
        pagination = described_class.new(skip: 0, limit: 100, total: 50)

        expect(pagination.previous_page).to be_nil
      end

      context 'when skip is grater than zero' do
        it 'subtracts the limit to define the skip attribute of the previous page' do
          pagination = described_class.new(skip: 200, limit: 100, total: 500)

          expect(pagination.previous_page).to eq(OpenStruct.new(skip: 100, limit: 100))
        end

        context 'and the subtraction result is negative' do
          it 'sets the skip attribute to zero' do
            pagination = described_class.new(skip: 50, limit: 100, total: 500)

            expect(pagination.previous_page).to eq(OpenStruct.new(skip: 0, limit: 100))
          end
        end
      end
    end
  end

  describe '#next_page' do
    context 'when the amount of skipped entities summed by the limit equals the total' do
      it 'returns nil' do
        pagination = described_class.new(skip: 0, limit: 100, total: 100)

        expect(pagination.next_page).to be_nil
      end
    end

    context 'when the amount of skipped entities summed by the limit is lesser than the total' do
      it 'increments the skip value by the limit' do
        pagination = described_class.new(skip: 100, limit: 100, total: 500)

        expect(pagination.next_page).to eq(OpenStruct.new(skip: 200, limit: 100))
      end
    end
  end
end
