module PCR
  module Resource
    def rating_keys
      %w(rCourseQuality rInstructorQuality rDifficulty rCommAbility
         rInstructorAccess rReadingsValue rAmountLearned rWorkRequired
         rRecommendMajor rRecommendNonMajor rStimulateInterest
         rArticulateGoals rSkillEmphasis rHomeworkValuable
         rExamsConsistent rAbilitiesChallenged rClassPace
         rOralSkills rInstructorConcern rInstructorRapport
         rInstructorAttitude rInstructorEffective rGradeFairness
         rNativeAbility rTAQuality)
    end

    def set_attrs(attrs, json)
      attrs.each do |attr|
        self.instance_variable_set("@#{attr}", json['result'][attr] || json[attr])
      end
    end
  end
end
