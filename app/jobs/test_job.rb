class  TestJob < ApplicationJob

    def perform(str)
        puts str
    end
    
end