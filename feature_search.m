function  feature_search(data)
    
    %data = load('CS170_Small_Data__88.txt');
    current_set_of_features = []; 
    accuracies = zeros(1, size(data,2)-1); 
    for i = 1:size(data,2) -1
        %disp(['on the ', num2str(i), 'ith level of the search tree'])
        feature_to_add_at_this_level = []; 
        best_accuracy = 0;
        
        for k = 1:size(data,2)-1
            if isempty(intersect(current_set_of_features, k))
                
                if isempty(current_set_of_features) 
                     disp(['Using feature(s) {', num2str(k), '}']);
                else 
                     disp(['Using feature(s) {', regexprep(num2str(current_set_of_features),'\s+',','),',', num2str(k), '}']);
                end 

                accuracy = cross_validation(data, current_set_of_features, k)*100; 
                disp(['Accuracy is ', num2str(accuracy), '%']); disp(' ');
                if accuracy > best_accuracy
                    best_accuracy= accuracy; 
                    accuracies(i) = best_accuracy; 
                    feature_to_add_at_this_level = k; 
                end
                
            end
        end
        
        current_set_of_features(i) = feature_to_add_at_this_level;
        disp(['This is the current set of features {' , regexprep(num2str(current_set_of_features),'\s+',','), '} at level ', num2str(i), ' accuracy is ', num2str(accuracies(i)), '%' ]);disp(' ');
    end 
    
    [M,I] = max(accuracies);
    disp(['Finished search !! The best feature set is {',regexprep(num2str(current_set_of_features(1:I)),'\s+',','), '}, ']); disp(['which has an accuracy of ' ,num2str(M),'%']); 
end  