require 'spec_helper'

describe 'clamav::default' do

  let(:clamav7_run) do
        runner = ChefSpec::Runner.new(platform:'redhat', version:'7.0') do |node|
  
        env = Chef::Environment.new
        env.name 'default'

        allow(Chef::Environment).to receive(:load).and_return(env)

        allow(node).to receive(:chef_environment).and_return(env.name)
      end

    runner.converge(described_recipe,"recipe[clamav::default]")
  end

  it "install clamav and clamav-update on rhel7" do
    expect(clamav7_run).to install_yum_package("clamav")
    expect(clamav7_run).to install_yum_package("clamav-update")
  end
end