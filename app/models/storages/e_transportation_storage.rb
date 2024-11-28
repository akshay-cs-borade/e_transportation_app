class Storages::ETransportationStorage
  def create(attrs)
    raise NotImplementedError
  end

  def all
    raise NotImplementedError
  end

  def outside_zone_grouped
    raise NotImplementedError
  end
end
