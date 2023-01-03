require './lib/museum'
require './lib/patron'
require './lib/exhibit'

RSpec.describe Museum do
  let(:dmns) { Museum.new("Denver Museum of Nature and Science") }
  let(:gems_and_minerals) { Exhibit.new({ name: "Gems and Minerals", cost: 0}) }
  let(:dead_sea_scrolls) { Exhibit.new({name: "Dead Sea Scrolls", cost: 10}) }
  let(:imax) { Exhibit.new({name: "IMAX",cost: 15}) }
  let(:patron_1) { Patron.new("Bob", 20) }
  let(:patron_2 ) { Patron.new("Sally", 20)}
  let(:patron_3) { Patron.new("Johnny", 5)}
  describe '#initialize and has attributes' do
    it 'exists' do
      expect(dmns).to be_a(Museum)
      expect(dmns.name).to eq("Denver Museum of Nature and Science")
    end
  end

  describe '#add_exhibit' do
    it 'has can add exhibits' do
      expect(dmns.exhibits).to eq([])

      dmns.add_exhibit(gems_and_minerals)
      dmns.add_exhibit(dead_sea_scrolls)
      dmns.add_exhibit(imax)

      expect(dmns.exhibits).to eq([gems_and_minerals, dead_sea_scrolls, imax])
    end
  end

  describe '#recommend_exhibits' do
    it 'can recommend exjibits to patrons' do
      dmns.add_exhibit(gems_and_minerals)
      dmns.add_exhibit(dead_sea_scrolls)
      dmns.add_exhibit(imax)

      patron_1.add_interest("Dead Sea Scrolls")
      patron_1.add_interest("Gems and Minerals")
      patron_2.add_interest("IMAX")

      expect(dmns.recommend_exhibits(patron_1)).to eq(["Dead Sea Scrolls", "Gems and Minerals"])
      expect(dmns.recommend_exhibits(patron_2)).to eq(["IMAX"])
    end
  end

  describe '#admit' do
    it 'can admit patrons' do
      dmns.add_exhibit(gems_and_minerals)
      dmns.add_exhibit(dead_sea_scrolls)
      dmns.add_exhibit(imax)

      patron_1.add_interest("Dead Sea Scrolls")
      patron_1.add_interest("Gems and Minerals")
      patron_2.add_interest("IMAX")
      patron_3.add_interest("Dead Sea Scrolls")

      expect(dmns.patrons).to eq([])

      dmns.admit(patron_1)
      dmns.admit(patron_2)
      dmns.admit(patron_3)

      expect(dmns.patrons).to eq([patron_1, patron_2, patron_3])
    end
  end

  describe '#patrons_by_exhibit_interest' do
    it 'can list patrons by exhibit interest' do
      dmns.add_exhibit(gems_and_minerals)
      dmns.add_exhibit(dead_sea_scrolls)
      dmns.add_exhibit(imax)

      patron_1.add_interest("Dead Sea Scrolls")
      patron_1.add_interest("Gems and Minerals")
      patron_2.add_interest("IMAX")
      patron_3.add_interest("Dead Sea Scrolls")

      dmns.admit(patron_1)
      dmns.admit(patron_2)
      dmns.admit(patron_3)

      expected_hash = { 
        "Dead Sea Scrolls" => [:patron_1, :patron_3],
        "Gems and Minderals" => [:patron_1],
        "Imax" => [:patron_2] }

      expect(dmns.patrons_by_exhibit_interest).to eq(expected_hash)
    end
  end 

  describe '#ticket_lottery_contestants' do
    xit 'returns an array of patrons that are interested in that exhibit but do not have enough money' do
      dmns.add_exhibit(gems_and_minerals)
      dmns.add_exhibit(dead_sea_scrolls)
      dmns.add_exhibit(imax)

      patron_1.add_interest("Dead Sea Scrolls")
      patron_1.add_interest("Gems and Minerals")
      patron_2.add_interest("IMAX")
      patron_3.add_interest("Dead Sea Scrolls")

      dmns.admit(patron_1)
      dmns.admit(patron_2)
      dmns.admit(patron_3)

      expect(dmns.ticket_lottery_contestants).to eq()
    end
  end 

end    