# Chef::Handler::StatusNotifier

Chef Handler for Status Notifier. This is being used here, https://github.com/faizalzakaria/chef-run-notifier .

## Usage

In your Chef recipe,

```ruby
chef_gem 'chef-handler-status_notifier' do
  compile_time true if respond_to?(:compile_time)
  action :upgrade
end

chef_handler 'StatusNotifierHandler' do
  source 'chef/handler/status_notifier'
  arguments [node['run_notifier']['slack'], node['run_notifier']['hipchat']]
  action :nothing
end.run_action(:enable)
```

## Contributing

1. Fork it ( https://github.com/[my-github-username]/chef-handler-status_notifier/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
