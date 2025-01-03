# frozen_string_literal: true

ActiveJob::Base.queue_adapter = :test

def clear_enqueued_jobs
  ActiveJob::Base.queue_adapter.enqueued_jobs.clear
end

# def clear_performed_jobs
#   ActiveJob::Base.queue_adapter.performed_jobs.clear
# end
