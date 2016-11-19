require 'takeaway'

describe Takeaway do

  subject(:takeaway) { described_class.new }
  let(:menu_hash) { double(:menu_hash) }
  let(:item) { double(:item) }
  let(:unavailable_item) { double(:unavailable_item) }
  let(:expected_total) { double(:expected_total) }

  it 'receives a menu object when created' do
    expect(takeaway.menu).not_to be_nil
  end

  it 'has an items hash ready to be filled with menu items' do
    expect(takeaway.items).to be_kind_of(Hash)
  end

  it 'prints the menu to the screen' do
    expect{takeaway.show_menu}.to output.to_stdout
  end

  context 'when ordering' do
    before(:each) do
      allow(Menu::MENU).to receive(:has_key?).and_return(true)
    end

    it 'if no quantity is given the default quantity of 1 will be given' do
      takeaway.add_item(item)
      expect(takeaway.items.has_value?(1)).to eq true
    end

    it 'adds your chosen item to items' do
      takeaway.add_item(item, 1)
      allow(menu_hash).to receive(:has_key?).and_return(true)
      expect(takeaway.items.empty?).to eq false
    end

    it 'increments the quantity of the item if the same item has been added more than once' do
      takeaway.add_item(item, 1)
      takeaway.add_item(item, 1)
      expect(takeaway.items.has_value?(2)).to eq true
    end

    context 'raising errors if item or quantity invalid' do
      it 'raises an error if quantity is less than 1' do
        allow(Menu::MENU).to receive(:has_key?).and_return(true)
        expect { takeaway.add_item(item, -10) }.to raise_error('Quantity cannot be less than 1')
      end

      it 'raises an error if you try to add something that is not on the menu' do
        allow(Menu::MENU).to receive(:has_key?).and_return(false)
        expect { takeaway.add_item(unavailable_item, 1) }.to raise_error('This item is not on the menu, please choose something else')
      end
    end

    context 'calculating total for order' do
      it 'stores the expected total' do
        expect(takeaway.expected_total(1)).not_to be_nil
      end
    end
  end
end
