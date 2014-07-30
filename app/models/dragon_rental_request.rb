class DragonRentalRequest < ActiveRecord::Base

  STATUSES = %w(PENDING APPROVED DENIED)

  validates :dragon_id, :start_date, :end_date, presence: true
  validates :status, :inclusion => {
             in: STATUSES,
             message: "%{value} is not a valid status"
           }

  validate :no_overlapping_approved_requests

  belongs_to(
    :dragon,
    :class_name => "Dragon",
    :foreign_key => :dragon_id,
    :primary_key => :id
  )

   def overlapping_requests
     overlaps = DragonRentalRequest.find_by_sql([<<-SQL, self.end_date, self.start_date])
     select *
     from dragon_rental_requests as drr
     where drr.dragon_id = #{self.dragon_id}
     and not ((drr.start_date > ?) or (drr.end_date < ?))
     SQL

     overlaps.reject { |overlap| overlap.id == self.id }
   end

   def no_overlapping_approved_requests
     overlaps = overlapping_requests

     if overlaps.any? { |overlap| overlap.status == "APPROVED" }
       errors[:base] << "Overlaps!"
     end
   end

end