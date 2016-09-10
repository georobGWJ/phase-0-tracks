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

  it "Test user_guess method with incorrect guess" do
    game.user_guess("fumigator")
    expect(game.phrases_guessed).to include "fumigator"
    expect(game.guesses_made).to eq 1
    expect(game.pretty_print).to eq "_ _ _ i g a t o r "
  end

  it "Test user_guess method with correct guess" do
    game.user_guess("alligator")
    expect(game.phrases_guessed).to include "alligator"
    expect(game.guesses_made).to eq 1
    expect(game.pretty_print).to eq "a l l i g a t o r "
  end 

  it "Test failure due to too many guesses" do
    game.user_guess("helicopter")
    game.user_guess("elephants")
    game.user_guess("coyotes")
    game.user_guess("bobolinks")
    game.user_guess("billybobb")
    game.user_guess("showntsag")
    game.user_guess("ipsumfalc")
    game.user_guess("burpsings")
  end
end