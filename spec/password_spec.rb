require './password'
describe Password do
  describe 'password strength' do
    #see README for the strong, ok, bad criteria
    let(:strong_password)     {Password.new('Asd$123ZXC')}
    let(:ok_password)         {Password.new('asdf123ZXC')}
    let(:bad_password)        {Password.new('asdf123zxc')}
    #passwords that meet the 4 criteria but are either short or repetitive will
    #still get a 'bad' message
    let(:repetition_password) {Password.new('Asd$111ZXC')}
    let(:short_password)      {Password.new('Asd$123ZX')}


    describe 'password strength' do
      it 'returns strong for a strong password' do
        expect(strong_password.strength).to eq('strong')
      end

      it 'returns ok for a password meeting 3 criteria' do
        expect(ok_password.strength).to eq('ok')
      end

      it 'returns weak for a password meeting less than 3 criteria' do
        expect(bad_password.strength).to eq('weak')
      end

      it 'returns weak for a password that has three repetitive characters' do
        expect(repetition_password.strength).to eq('weak')
      end

      it 'returns weak for a password with less than 10 characters' do
        expect(short_password.strength).to eq('weak')
      end
    end


  end
end
