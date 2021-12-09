# frozen_string_literal: true

class FakeResourceFull < Enginn::Resource
  resource 'fakes'
end

class FakeResourceLimited < Enginn::Resource
  resource 'fakes', only: :get
end

RSpec.describe Enginn::Resource do
  describe '.resource' do
    context 'without resource limitations' do
      it 'defines all resourceful methods' do
        expect(FakeResourceFull).to respond_to(*Enginn::Resource::HTTP_VERBS)
      end
    end

    context 'with resource limitations' do
      it 'defines the selected resource methods' do
        expect(FakeResourceLimited).to respond_to(:get)
      end

      it 'does not define the other methods' do
        expect(FakeResourceLimited).not_to respond_to(
          *Enginn::Resource::HTTP_VERBS.difference([:get])
        )
      end
    end
  end
end
