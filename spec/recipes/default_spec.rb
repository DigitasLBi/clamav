require_relative '../spec_helper'

describe 'clamav::default' do

  let(:clamav_run) do
        runner = ChefSpec::Runner.new(platform:'redhat', version:'6.5') do |node|
  
        env = Chef::Environment.new
        env.name 'default'

        allow(Chef::Environment).to receive(:load).and_return(env)

        allow(node).to receive(:chef_environment).and_return(env.name)
      end

    runner.converge(described_recipe,"recipe[clamav::default]")
  end

  it "install clamav do" do
    expect(clamav_run).to install_yum_package("clamav")
  end

  it "create log directory" do
    expect(clamav_run).to create_directory('/var/log/clamav').with(owner: 'clam')
  end

  it "creates template for freshclam conf" do
    expect(clamav_run).to create_template('/etc/freshclam.conf')
  end

  it "create user necessary to run clamav/use database" do
    expect(clamav_run).to create_user("clam")
  end

  it "creates log files for the clam user" do
    expect(clamav_run).to create_file_if_missing('/var/log/clamav/clamscan.log').with(
      user:   'clam'
    )

    expect(clamav_run).to create_file_if_missing('/var/log/clamav/freshclam.log').with(
      user:   'clam'
    )
  end

  it "create cron jobs for database update" do
    expect(clamav_run).to create_cron('clam database update').with(weekday: '1')
  end

  it "create cron jobs for clamscan" do
    expect(clamav_run).to create_cron('clamscan').with(weekday: '1')
  end
end