def create_job_order(jobs)
  # Split the string into an array of individual jobs
  jobs_array = jobs.split(',')

  # Create a hash of each job's (current position * 2) in the order to be exectuted
  position = 2
  positions_hash = {}
  jobs_array.each do |job|
    positions_hash[job.chars.first] = position
    position += 2
  end

  # Create a hash of the positional rules that must be followed
  rules_hash = {}
  jobs_array.each do |job|
    job.length > 1 ? rules_hash[job.chars.first] = job.chars.last : rules_hash[job] = nil
  end

  # Return an error if any jobs depend on themselves
  rules_hash.each do |key, value|
    return "Error: Jobs cannot depend on themselves" if key == value
  end

  # Iterate over the rules hash and alter the values of the positions hash to reflect jobs which must be done before other jobs. This is done twice to account for rules that affect jobs which have already been iterated over
  2.times do
    rules_hash.each do |key, value|
      positions_hash[key] = positions_hash[value] + 1 if value
    end
  end

  # Check whether the positions now match all the rules, if not return an error that the rules contain circular dependencies
  rules_hash.each do |key, value|
    if value
      return "Error: This jobs list contains circular dependencies" if positions_hash[value] > positions_hash[key]
    end
  end

  # Iterate over the positions hash and append the keys to an array on the order that each job should be done
  ordered_jobs = []
  (jobs_array.count * 3).times do |x|
    positions_hash.each do |key, value|
      ordered_jobs << key if (x + 1) == value
    end
  end

  # Turn the final array back into a string to be returned
  return_string = ordered_jobs.join(",")
end

p scenario1 = create_job_order("") # Should return an empty sequence
p scenario2 = create_job_order("a") # Should return 'a'
p scenario3 = create_job_order("a,b,c") # Should return the three jobs in any order
p scenario4 = create_job_order("a,b-c,c") # Should position 'c' before 'b'
p scenario5 = create_job_order("a,b-c,c-f,d-a,e-b,f") # Should return 'f' before 'c', 'c' before 'b', 'b' before 'e' and 'a' before 'd'
p scenario6 = create_job_order("a,b,c-c") # Should return an error
p scenario7 = create_job_order("a,b-c,c-f,d-a,e,f-b") # Should return an error
