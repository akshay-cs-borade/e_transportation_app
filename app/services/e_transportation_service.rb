class ETransportationService
  def self.storage
    if use_in_memory?
      ::Storages::InMemory::ETransportationStorage
    else
      ::Storages::Db::ETransportationStorage
    end
  end

  def self.use_in_memory?
    ENV['USE_IN_MEMORY'] == 'true' # You can configure this in your .env file or config
  end

  def self.create_e_transportation(attrs)
    storage.create(attrs)
  end

  def self.all_e_transportations
    storage.all
  end

  def self.outside_zone_grouped
    storage.outside_zone_grouped
  end
end
