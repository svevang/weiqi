require 'spec_helper'

describe 'Weiqi services are running' do

  describe service('mongodb'), :if => os[:family] == 'ubuntu' do
    it { should be_enabled }
    it { should be_running }
  end

end
