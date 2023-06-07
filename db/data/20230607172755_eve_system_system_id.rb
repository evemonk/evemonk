# frozen_string_literal: true

class EveSystemSystemId < ActiveRecord::Migration[7.0]
  def up
    # Eve::System.find_each do |system|
    #   system.update_column(:id, system.system_id)
    #
    #   # TODO: broken primary key for polymorfic
    #
    #   # [48] pry(main)> Eve::Position.where(positionable_type: "Eve::System").count
    #   # => 8435
    #   # [49] pry(main)> Eve::System.count
    #   # => 8435
    #
    #   # [51] pry(main)> Eve::System.first.position
    #   # => nil
    #   # [52] pry(main)> Eve::System.first.id
    #   # => 30000001
    #   # [53] pry(main)> Eve::System.pluck(:id).sort.first
    #   # => 1
    #   # [54] pry(main)>
    # end
  end

  def down
    raise ActiveRecord::IrreversibleMigration
  end
end
