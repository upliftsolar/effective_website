class CommunitiesDatatable < Effective::Datatable

  filters do
    scope :unarchived, label: 'All'
    scope :archived
  end

  datatable do
    order :updated_at, :desc

    col :id, visible: false
    col :updated_at, label: 'Updated', visible: false
    col :created_at, label: 'Created', visible: false

    col :name

    col :more_info do |c|
      if c.flyer.attached?
        link_to("[flyer]", rails_blob_path(c.flyer, disposition: 'attachment'))
      end
    end

    col :archived, search: { value: false }

    actions_col
  end

  collection do
    Community.deep.all
  end

end
