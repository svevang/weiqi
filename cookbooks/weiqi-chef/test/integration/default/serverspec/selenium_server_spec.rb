require 'spec_helper'

describe 'Selenium server status' do

  describe service('supervisor'), :if => os[:family] == 'ubuntu' do
    it { should be_enabled }
    it { should be_running }
  end

  describe port(4444) do
      it { should be_listening }
  end

end
