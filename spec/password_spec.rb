require './password'
require './sinatra_server'
require 'capybara'
require 'capybara/rspec'

Capybara.app = Sinatra::Application
RSpec.configure do |config|
  config.include Capybara
end
Capybara.register_driver :chrome do |app|
  Capybara::Selenium::Driver.new(app, :browser => :chrome)
end

describe Password do
  describe 'password strength' do
    #see README for the strong, ok, weak criteria
    let(:strong_password)     {Password.new('Asd$123ZXC')}
    let(:ok_password)         {Password.new('asdf123ZXC')}
    let(:weak_password)        {Password.new('asdf123zxc')}
    #passwords that meet the 4 criteria but are either short or repetitive will
    #still get a 'weak' message
    let(:short_password)      {Password.new('Asd$123ZX')}


    describe 'password strength by default rules' do
      it 'returns strong for a strong password' do
        expect(strong_password.strength).to eq('strong')
      end

      it 'returns ok for a password meeting 3 criteria' do
        expect(ok_password.strength).to eq('ok')
      end

      it 'returns weak for a password meeting less than 3 criteria' do
        expect(weak_password.strength).to eq('weak')
      end

      it 'returns weak for a password with less than 10 characters' do
        expect(short_password.strength).to eq('weak')
      end
    end

    describe 'password strength by custom rules' do
      let(:custom_strong_password) {Password.new('aaaaaaaaaa', score: {strong: 1})}
      let(:custom_rule_password) {Password.new('aaaaaaaaaa', score: {strong: 1})}
      let(:custom_requirement_password) {Password.new('Asd$123ZX', requirement: {})}

      it 'returns strong for a password that meets one rule' do
        expect(custom_strong_password.strength).to eq('strong')
      end

      it 'returns strong for a password that doesn\'t meet required rules but meets all optional rules' do
        expect(custom_requirement_password.strength).to eq('strong')
      end


    end

  end

describe "visit password strength page", type: :feature do

  it "has title password strength" do
    visit '/'
    expect(page).to have_content 'password strength!'
  end
end
end
