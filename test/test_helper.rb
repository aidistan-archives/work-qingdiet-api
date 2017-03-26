ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'
require 'webmock/minitest'
require 'minitest/reporters'
Minitest::Reporters.use! Minitest::Reporters::SpecReporter.new

class ActiveSupport::TestCase
  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all

  # Create a test for fixtures
  def self.test_fixtures
    model = to_s.sub(/Test$/, '').constantize

    test 'fixtures should be valid' do
      model.all.each { |record| assert record.valid? }
    end
  end

  # Create a test for dependent associations
  def self.test_dependent_associations(destroy: [], exception: [], &block)
    destroy = [destroy] unless destroy.respond_to?(:each)
    exception = [exception] unless exception.respond_to?(:each)
    model_name = to_s.sub(/Test$/, '').underscore

    test 'dependencies should be handled' do
      instance = instance_variable_get('@' + model_name)

      # Dependencies should have at least one record to test
      (destroy + exception).each do |m|
        assert_not m.where("#{model_name}_id" => instance.id).empty?
      end

      # With :exception dependencies, it should raise exceptions when destroying
      exception.each do |m|
        assert_raises(ActiveRecord::DeleteRestrictionError) { instance.destroy }
        m.where("#{model_name}_id" => instance.id).destroy_all
      end

      # After destroying exception dependencies, the instance could be destroyed now
      assert_nothing_raised { instance.destroy }

      # After destroying the instance, :destroy dependencies should be destroyed too
      destroy.each do |m|
        assert m.where("#{model_name}_id" => instance.id).empty?
      end

      yield if block
    end
  end

  # Setup contexts for policy tests
  def setup_context
    token = tokens(:one)
    @user = token.user
    @context = [token.app, token.user, token]
    token = tokens(:two)
    @other_user = token.user
    @other_context = [token.app, token.user, token]
  end
end
