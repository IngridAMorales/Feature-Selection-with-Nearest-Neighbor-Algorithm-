function accuracy = cross_validation(data, current_set, features_to_add)
   number_correctly_classified = 0;
 
   features = current_set; 
   features(end+1) = features_to_add; 
   for i = 1:size(data,1)
        for j = 1:size(data,2)-1
            if j ~= features
                data(i,j+1) = 0;  
            end
        end 
   end 
   
   for i = 1:size(data,1) %rows (# of data points)
       
       object_to_classify = data(i,2:end); %features 
       label_object_to_classify = data(i,1); %class label

        nearest_neighbor_distance = inf; 
        nearest_neighbor_location = inf;
        for k = 1: size(data,1)
            if k ~=i
                ecudistance = sqrt(sum((object_to_classify - data(k,2:end)).^2)); 
                if ecudistance < nearest_neighbor_distance
                    nearest_neighbor_distance = ecudistance; 
                    nearest_neighbor_location = k; 
                    nearest_neighbor_label = data(nearest_neighbor_location, 1); 
                end
            end
        end
        if label_object_to_classify == nearest_neighbor_label
            number_correctly_classified = number_correctly_classified+1; 
        end
   end    
   accuracy =  number_correctly_classified / size(data,1);  
end
