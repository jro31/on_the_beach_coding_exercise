def create_job_order(jobs)
  jobs_array = jobs.split(',') # 1)
  jobs_hash = {}
  jobs_array.each do |job| # 2)
    job.length <= 1 ? jobs_hash[job] = nil : jobs_hash[job.chars.first] = job.chars.last
  end
  p jobs_hash
end

p scenario1 = create_job_order("") # Should return an empty sequence
p scenario2 = create_job_order("a") # Should return 'a'
p scenario3 = create_job_order("a,b,c") # Should return the three jobs in any order
p scenario4 = create_job_order("a,b-c,c") # Should position 'c' before 'b'
p scenario5 = create_job_order("a,b-c,c-f,d-a,e-b,f") # Should return 'f' before 'c', 'c' before 'b', 'b' before 'e' and 'a' before 'd'
p scenario6 = create_job_order("a,b,c-c") # Should return an error
p scenario7 = create_job_order("a,b-c,c-f,d-a,e,f-b") # Should return an error


# 1) Split the strings into arrays of individual items
# 2) Split this array into a hash whereby the intial jobs are keys and the prioritised jobs are values (or nil)
