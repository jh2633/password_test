require 'spec_helper'

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
      let(:custom_requirement_password) {Password.new('Asd$3', requirement: {})}

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
      expect(page).to have_content 'Password Strength Test!'
    end

    it "does not analyze an empty field" do
      visit '/'
      expect(page).to have_no_content 'weak'
    end
  end

  describe "password analysis feature", js: true, type: :feature do

    it "returns weak for a password meeting less than three requirements" do
      visit '/'
      fill_in 'pwd', with: 'password'
      expect(page).to have_content 'weak'
    end

    it "returns weak for a password meeting all requirement except for length" do
      visit '/'
      fill_in 'pwd', with: 'aSh0rtpw!'
      expect(page).to have_content 'weak'
    end


    it "returns ok for a password meeting three requirements" do
      visit '/'
      fill_in 'pwd', with: 'asdf123ZXC'
      expect(page).to have_content 'ok'
    end

    it "returns strong for a password meeting all requirements" do
      visit '/'
      fill_in 'pwd', with: 'Asd$123ZXC'
      expect(page).to have_content 'strong'
    end


  end
end
