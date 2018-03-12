function x = spoof_resilient_wmsr(delay_flag, x_0)
%Function resilient_wmsr updates the information state of each
%vehicles after sorting & removing extreme values from its in-neighbors
%according to W_MSR algorithm    
    m = size(x_0,1);
    F = 1;
    x = zeros(m, 1);        
    x(7) = 20 + randn;
    if(delay_flag)
        x(8) = 20 + randn;
    end
  
    % Before Detecting Spoofing Attack
    degree_vector_1 = [2 3 4 4 5 4 2 2];
    D_1 = diag(degree_vector_1);
    A_1 = [0 1 1 0 0 0 0 0
           1 0 1 1 0 0 0 0
           1 1 0 1 1 0 0 0
           0 1 1 0 1 1 0 0
           0 0 1 1 0 1 1 1
           0 0 0 1 1 0 1 1
           0 0 0 0 1 1 0 0
           0 0 0 0 1 1 0 0];
    L_1 = D_1 - A_1;
    
    % After Detecting Spoofing Attack    
    D_2 = D_1(1:end-1, 1:end-1); % Removing Spoofed Node
    A_2 = A_1(1:end-1, 1:end-1); % Removing Spoofed Node 
    L_2 = D_2 - A_2;
%     error = zeros(m, delay); % data structure to store the delay effect    
    if(delay_flag)
        for i = 1:m  
            if (i~=7 && i~=8)                
                L_i_row = L_1(i,:)';
                before_sort = [x_0 L_i_row];
                % Extract only in-neighbors
                condition = L_i_row >= 0;
                before_sort(condition,:) = [];  
                before_sort = before_sort(:,1);                      
                % removing larger values - sort descendingly
                ascend_sort = sortrows(before_sort, -1);              
                indices = ascend_sort > x_0(i);
                if(~isempty(indices))
                    if(length(indices) > F)
                        % if # of values larger than x(i) > F, delete F larger ones
                        for j = 1:F
                            ascend_sort(indices(j),:) = [];
                        end
                    else
                        % else delete all larger values
                        ascend_sort(indices,:) = [];
                    end
                end
                % removing smaller values - sort ascendingly           
                ascend_sort = sortrows(ascend_sort);
                indices = find(ascend_sort < x_0(i));
                if(~isempty(indices))
                    if(length(indices) > F)
                        for j = 1:F
                            ascend_sort(indices(j),:) = [];
                        end
                    else
                        ascend_sort(indices,:) = [];
                    end
                end
                remaining_count = length(ascend_sort);
                weight = 1/(remaining_count+1);
                sum_weights = sum(ones(remaining_count+1,1)*weight); % should be 1
                x(i) = sum(weight*ascend_sort) + weight* x_0(i); 
            end
        end
    else
        for i = 1:m       
            if (i~=7)
                L_i_row = L_2(i,:)'; % use new L matrix
                before_sort = [x_0 L_i_row];
                % Extract only in-neighbors
                condition = L_i_row >= 0;
                before_sort(condition,:) = [];  
                before_sort = before_sort(:,1);                      
                % removing larger values - sort descendinlgy
                ascend_sort = sortrows(before_sort, -1);              
                indices = find(ascend_sort > x_0(i));
                if(~isempty(indices))
                    if(length(indices) > F)
                        % if # of values larger than x(i) > F, delete F larger ones
                        for j = 1:F
                            ascend_sort(indices(j),:) = [];
                        end
                    else
                        % else delete all larger values
                        ascend_sort(indices,:) = [];
                    end
                end
                % removing smaller values - sort ascendingly
                ascend_sort = sortrows(ascend_sort);
                indices = find(ascend_sort < x_0(i));
                if(~isempty(indices))
                    if(length(indices) > F)
                        for j = 1:F
                            ascend_sort(indices(j),:) = [];
                        end
                    else
                        ascend_sort(indices,:) = [];
                    end
                end
                remaining_count = length(ascend_sort);
                weight = 1/(remaining_count+1);
                sum_weights = sum(ones(remaining_count+1,1)*weight); % should be 1
                x(i) = sum(weight*ascend_sort) + weight* x_0(i);             
            end
        end
    end
end