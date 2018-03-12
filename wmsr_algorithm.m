function x = wmsr_algorithm(time_span,x_0)
%Function modified_wmsr updates the information state of each
%vehicles after sorting & removing extreme values from its in-neighbors
    
    m = size(x_0,1);
    F = 1; % Number of malicious nodes
    %xdot = zeros(m,1);
    %L=[2 -1 0 0 -1; -1 3 -1 0 -1; 0 -1 2 -1 0; 0 0 -1 2 -1; -1 -1 0 -1 3]; % 5 nodes
    D = diag([2 3 4 4 4 3 2]);
    A = [0 1 1 0 0 0 0 
         1 0 1 1 0 0 0
         1 1 0 1 1 0 0
         0 1 1 0 1 1 0
         0 0 1 1 0 1 1
         0 0 0 1 1 0 1
         0 0 0 0 1 1 0];
    L = D - A;
    %L = eye(m) - D^(-0.5)*A*D^(0.5);
    time_vec = 1:1:time_span;
    x = zeros(m, length(time_vec)+1);
    % Set values of all vehicles at time = 0 to x_0
    x(:,1) = x_0;
    %x(4,:) = 300;
    x(4,:) = 20 + randn(length(time_vec)+1,1);
    
    for k = 1:length(time_vec)
        for i = 1:m  
            if (i~=4)     
                %x(4,k) = 200 + randn(); % Malicious node #4 holding onto constant value
                L_i_row = L(i,:)';
                before_sort = [x(:,(k)) L_i_row];
                % Extract only in-neighbors
                condition = L_i_row >= 0;
                before_sort(condition,:) = [];  
                before_sort = before_sort(:,1);                      
                % removing larger values - sort descendingly
                ascend_sort = sortrows(before_sort, -1);              
                indices = ascend_sort > x(i,(k));
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
                % removing smaller values            
                ascend_sort = sortrows(ascend_sort);
                indices = find(ascend_sort < x(i,(k)));
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
                x(i,k+1) = sum(weight*ascend_sort) + weight* x(i,(k)); 
            end
        end
    end    
end