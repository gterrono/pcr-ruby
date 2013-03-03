require 'pcr/resource'
require 'pcr/coursehistory'

module PCR
  class Department
    include PCR::Resource
    attr_reader :name, :coursehistories, :id, :path, :retrieved, :valid, :version
    
    def initialize(name)
      @name = name
      
      # Read JSON from PCR API
      json = PCR.get_json("depts/#{self.name}")
      
      # List of course_histories in department
      @coursehistories = json['result']['coursehistories'].map do |course|
        CourseHistory.new(course['aliases'].last)
      end

      # Assign rest of attrs
      attrs = %w(id path reviews retrieved valid version)
      set_attrs(attrs, json)
    end
  
    def average(metric)
      # Aggregate ratings across all coursehistories
      total, num = 0, 0
      coursehistories.each do |c|
        av = c.average(metric).to_f
        if av != -1
          total += av
          num += 1
        end
      end
      
      # Return average value across all sections
      total / num
    end

    def courses
      @courses ||= @coursehistories.inject([]) { |r, c| r  + c.courses }
    end
  end
end
