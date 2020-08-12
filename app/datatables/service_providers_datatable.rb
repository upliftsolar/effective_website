class ServiceProvidersDatatable < Effective::Datatable

  filters do
    scope :deep, label: 'All'
    scope :solar_installer
  end

  datatable do
    order :updated_at

    col :updated_at, visible: false
    col :created_at, visible: false
    col :id, visible: false

    col :name do |sp|
      link_to sp.name, sp
    end
    col :title
    col :locality
    col :contact do |sp|
      [sp.email,sp.phone].join(" :: ")
    end
    actions_col
  end

  collection do
    ServiceProvider.deep.all
  end

end
