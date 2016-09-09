require_relative 'WordGame'

describe WordGame do

  let(:game) { WordGame.new("alligator", "Vinny", "Austin") }

  it "Initializes Game State Properly" do
    expect(game.phrase).to eq "alligator"
    expect(game.player1).to eq "Vinny"
    expect(game.player2).to eq "Austin"
    expect(game.chars_guessed).to eq [['a',false],['l',false],['l',false],
      ['i',false],['g',false],['a',false],['t',false],['o',false],['r',false]]
    expect(game.guesses_made).to eq 0
    expect(game.guesses_allowed).to eq 8
  end

  it "Test initial pretty_print method response" do
    expect(game.pretty_print).to eq "_ _ _ _ _ _ _ _ _ "
  end
end