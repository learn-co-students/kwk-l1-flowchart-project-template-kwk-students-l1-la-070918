def res(one, two, three, four, five)
  ok = 0
  bipolar = 0 
  depression = 0 
  anxiety = 0
  eating_dis = 0
  
  if one == "true" 
   ok += 1
  else one == "false"
   decide += 1
  bipolar += 1 
  depression += 1
  anxiety += 1
  eating_dis += 1
  end
  if two == "true"
    bipolar += 1
    anxiety +=1
  else two == "false"
    ok += 1 
  end
  if three == "true"
    anxiety += 1 
  else three == "false"
    ok += 1
  end
  if four == "true"
    eating_dis += 1
    depression +=1
  else four == "false"
    ok +=1
  end
  if five == "true"
    depression += 1
    anxiety +=1 
    eating_dis +=1
  else five == "false"
    ok += 1
  end

result = ""

result_array = [ok, bipolar, depression, anxiety,eating_dis]
  if result_array.max == eating_dis
    result = "Make a list of positive affirmations. Pick one, look at yourself in the mirror and say if morning and night for 21 days. The affirmation will become a part of you!"
    
  elsif result_array.max == bipolar
    result = "Some coping strategies thay may help you are: Controlling your stress, Keeping a regular schedule, practicing a healthy sleep schedule, get moving (a nice walk can help clear your mind!), and to write your feelings down  "
    
  elsif result_array.max == depression
    result = "It seems like you are having a rough time, make sure to reach out and stay connected, there is always someone out there who cares! Try doing an activity you love, or used to love doing, you may start to feel better!"
    #puts "upset"
  elsif result_array.max == anxiety
    result = "Life can get pretty stressful, it's ok to worry sometimes, but dont let it control you! Next time you feel anxious, slowly count to 10 and practice taking deep breaths. Following a regular schedule may also help you relieve some worry!"
    #puts "stressed"
  else 
    result = "Keep doing what you are doing! You are healthy and happy!"
  end
return result
end