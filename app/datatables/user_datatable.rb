class UserDatatable < AjaxDatatablesRails::Base
  def_delegator :@view, :link_to

  def view_columns
    # Declare strings in this format: ModelName.column_name
    # or in aliased_join_table.column_name format
    @view_columns ||= {
      # id: { source: "User.id", cond: :eq },
      # name: { source: "User.name", cond: :like }
      name: { source: "User.name", cond: :like, searchable: true, orderable: true },
      email: { source: "User.email", cond: :like, searchable: true, orderable: true },
      created_at: { source: "User.created_at", cond: :like, searchable: true, orderable: true },
      updated_at: { source: "User.updated_at", cond: :like, searchable: true, orderable: true },
    }
  end

  def data
    records.map do |record|
      {
        # example:
        # id: record.id,
        # name: record.name
        name: link_to(record.name, record),
        email: record.email,
        created_at: record.created_at,
        updated_at: record.created_at
      }
    end
  end

  private

  def get_raw_records
    # insert query here
    User.all
  end

  # ==== These methods represent the basic operations to perform on records
  # and feel free to override them

  # def filter_records(records)
  # end

  # def sort_records(records)
  # end

  # def paginate_records(records)
  # end

  # ==== Insert 'presenter'-like methods below if necessary
end
