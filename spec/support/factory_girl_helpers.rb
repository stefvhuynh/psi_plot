module FactoryGirlHelpers
  def build_attributes(*args)
    FactoryGirl.build(*args).attributes.delete_if do |key, value|
      ['id', 'created_at', 'updated_at'].member?(key)
    end
  end
end

RSpec.configure do |config|
  config.include FactoryGirlHelpers
end
