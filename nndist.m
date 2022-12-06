
%Nearest distance algorithm 
function nndist()
    %data = load('CS170_Small_Data__96.txt'); 
    
    disp('Welcome to Ingrids Feature Selection Algorithm'); 
    prompt = "Type in the name of the file you want to test : ";
    txt = input(prompt,"s");
    while isempty(txt)
         prompt = "Type in the name of the file you want to test : ";
         txt = input(prompt,"s");
         data = load(txt); 
    end
    data = load(txt); 
    
    prompt = "Type in the number of the algorithm you want to run : "; 
    disp('(1) Forward elimination'); 
    disp('(2) Backward elimination'); 
    x = input(prompt); 
    disp(' '); 
   % while x~=1 || x~= 2 
    %    prompt = "Type in the number of the algorithm you want to run: "; 
     %   disp('(1) Forward Elimination'); 
      %  disp('(2) Backward Elimination'); 
       % x = input(prompt); 
        %disp(' '); 
    %end 
    
    features = 1:size(data,2)-1; 
    disp(['This dataset has ' ,num2str(size(features,2)), ' features, with ', num2str(size(data,1)), ' instances ']);
    accuracy_without_search = cross_validation(data, features, 0)*100;
    disp(['Running nearest neighbor with all ' ,num2str(size(features,2)), ' features, using "leaving-one-out" evaluation, I get an accuracy of ', num2str(accuracy_without_search),'%']);
    disp(' '); 
    
    if x==1 
        disp('Beginning Forward elimination: '); 
        feature_search(data); 
    else
        disp('Beginning Backward elimination: '); 
        backward_elimination(data);
    end 
   
   
end 


