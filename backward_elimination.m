function backward_elimination(data)

    %data = load('CS170_Small_Data__88.txt');
    
    %starts with all features in set
    current_set_of_features = 1:size(data,2)-1;
    %keeps track of the features we eliminate at each level
    features_eliminated = [];
    %keeps the best accuracy at each level
    accuracies = zeros(1,size(data,2)-1); 
    %keep the best accuracy of each feature set at level i 
    accuracy = zeros(1, size(data,2)-1);
    %keeps track of the best feature set at each level 
    best_set = {}; 
    
    best_accuracy = cross_validation(data, current_set_of_features, 0)*100; 
    disp(['Current set of features ', regexprep(num2str(current_set_of_features),'\s+',','), ' with accuracy ', num2str(best_accuracy), '%']); 
    for i = 1:size(data,2)-1 
        %disp(['on the ', num2str(i), 'ith level of the search tree'])
        feature_to_remove_at_this_level = []; 
        
        for k = 1:size(data,2)-1
           if isempty(intersect(features_eliminated,k))
                %feature set 
                new_set = current_set_of_features; 
                index = find(new_set == k); 
                new_set(index) = [];  
                %accuracy of feature set
                accuracy(k) = cross_validation(data, new_set, 0)*100; 
                disp(['Using feature(s) {',  regexprep(num2str(new_set),'\s+',','), '}, accuracy is ', num2str(accuracy(k)), '%' ]);
                disp(' '); 
                if accuracy(k) >  best_accuracy 
                    best_accuracy = accuracy(k);
                    accuracies(i) = best_accuracy; 
                    best_set(i) = {new_set}; 
                    feature_to_remove_at_this_level = k;
                end 
           else 
               %reset accuracy of features that we already eliminated 
               accuracy(k) = 0;
           end
           
        end 
            %when we've already reached the best accuacy but we will
            %continue until feature set is empty
            if isempty(feature_to_remove_at_this_level)
                [M,I] = max(accuracy);
                best_accuracy = M;
                feature_to_remove_at_this_level = I;    
            end 
            
           
                disp(['On level ', num2str(i), ' I removed feature ' , num2str(feature_to_remove_at_this_level), ' to current set ']);  
                features_eliminated(i) = feature_to_remove_at_this_level;
                index = find(current_set_of_features == feature_to_remove_at_this_level);
                current_set_of_features(index) = []; 
                
                disp(['Current set of features {' , regexprep(num2str(current_set_of_features),'\s+',','), '}, accuracy is ', num2str(best_accuracy), '%']);
                disp(' '); 
    end
    [M,I] = max(accuracies);
    B = best_set(I); 
    set = cell2mat(B); 
    disp(['Finished search !! The best feature set {', regexprep(num2str(set),'\s+',','), '} is with an accuracy of ' ,num2str(M),'%']); 
end

     
