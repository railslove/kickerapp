require 'spec_helper'

describe 'validate FactoryBot factories' do
  FactoryBot.factories.each do |factory|
    context "with factory for :#{factory.name}" do
      subject { FactoryBot.build(factory.name) }

      it 'is valid' do
        is_valid = subject.valid?
        expect(is_valid).to eql(true), subject.errors.full_messages.join(',')
      end
    end
  end
end
