require 'spec_helper'

module Spree
  module Calculator::Shipping
    describe SimpleWeight, :type => :model do

      options = { preferred_costs_string: "0.5:5\n1:10\n50:20\n100:50.3",
                  preferred_handling_max: 120,
                  preferred_handling_fee: 21.5,
                  preferred_max_item_size: 35,
                  preferred_default_weight: 1 }

      let(:variant1) { build(:variant,   weight: 5,
                                         width: 1,
                                         depth: 1,
                                         height: 1,
                                         price: 4) }
      let(:variant2) { build(:variant,   weight: 10,
                                         width: 1,
                                         depth: 1,
                                         height: 1,
                                         price: 6) }
      let(:variant3) { build(:variant,   weight: 0.0,
                                         width: 1,
                                         depth: 1,
                                         height: 1,
                                         price: 10) }

      let(:package) do
        build(:stock_package, variants_contents: { variant1 => 4, variant2 => 6 })
      end

      let(:package2) do
        build(:stock_package, variants_contents: { variant3 => 1 })
      end

      subject { SimpleWeight.new(options) }

      it "correctly select the default weight shipping price when no weight on the variant", :focus => true do
        expect(subject.available?(package2)).to be true
        expect(subject.compute_package(package2)).to eq 31.5 # 10 shipping + 21.5 handling
      end

      it "correctly calculates shipping when handling fee applies" do
        expect(subject.available?(package)).to be true
        expect(subject.compute_package(package)).to eq 71.8 # 50.3 cost + 21.5 handling
      end

      it "correctly calculates shipping when handling fee does not apply" do
        allow(subject).to receive(:preferred_handling_max).and_return(10)

        expect(subject.available?(package)).to be true
        expect(subject.compute_package(package)).to eq 50.3
      end

      it "does not apply to overweight order" do
        allow(variant1).to receive(:calculator_weight).and_return(100)

        expect(subject.available?(package)).to be false
      end

      it "does not apply to order with oversize items" do
        allow(variant1).to receive(:depth).and_return(100)

        expect(subject.available?(package)).to be false
      end

      it "does not apply with invalid costs string" do
        allow(subject).to receive(:preferred_costs_string).and_return("")
        expect(subject.available?(package)).to be false

        allow(subject).to receive(:preferred_costs_string).and_return("20:")
        expect(subject.available?(package)).to be false

        allow(subject).to receive(:preferred_costs_string).and_return("50=20")
        expect(subject.available?(package)).to be false

        allow(subject).to receive(:preferred_costs_string).and_return("abc:dfg\nerge:67")
        expect(subject.available?(package)).to be false
      end

      it "correctly calculates shipping when costs string has useless spaces and newlines" do
        allow(subject).to receive(:preferred_costs_string).and_return(%q{50:20
                                                        100:50.3
                                                      })
        expect(subject.available?(package)).to be true
        expect(subject.compute_package(package)).to eq 71.8
      end
    end
  end
end
