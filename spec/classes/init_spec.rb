require 'spec_helper'
describe 'talend' do

  context 'with defaults for all parameters' do
    it { should contain_class('talend') }
  end
end
