def create_job_order(jobs)

end

puts scenario1 = create_job_order("")
puts scenario2 = create_job_order("a,b,c")
puts scenario3 = create_job_order("a,b-c,c")
puts scenario4 = create_job_order("a,b-c,c-f,d-a,e-b,f")
puts scenario5 = create_job_order("a,b,c-c")
puts scenario6 = create_job_order("a,b-c,c-f,d-a,e,f-b")
