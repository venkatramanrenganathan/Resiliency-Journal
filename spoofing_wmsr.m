function x = spoofing_wmsr(x_0)
%Function spoofing_wmsr updates the information state of each
%vehicles after sorting & removing extreme values from its in-neighbors
    
    m = size(x_0,1);
    F = 1; % Number of malicious nodes
    D = diag([2 4 5 4 5 4 2 4]);
    A = [0 1 1 0 0 0 0 0
         1 0 1 1 0 0 0 1 
         1 1 0 1 1 0 0 1
         0 1 1 0 1 1 0 0
         0 0 1 1 0 1 1 1 
         0 0 0 1 1 0 1 1
         0 0 0 0 1 1 0 0
         0 1 1 0 1 1 0 0];
    L = D - A;
    x = zeros(m, 1);
    % Set values of all vehicles at time = 0 to x_0
%     x(4) = 20 + randn;
%     x(8) = 20 + randn;
    x(4) = x_0(4);
    x(8) = x_0(8);
    
    for i = 1:m  
        if (i~=4 && i~=8)
            L_i_row = L(i,:)';
            before_sort = [x_0 L_i_row];
            % Extract only in-neighbors
            condition = L_i_row >= 0;
            before_sort(condition,:) = [];  
            before_sort = before_sort(:,1);                      
            % removing larger values - sort descendingly
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
            % removing smaller values          
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
            if(abs(x(i) - x_0(i)) > 1)
                if(x(i) > x_0(i))
                    x(i) = x(i) - 0.75*abs(x(i) - x_0(i));
                else
                    x(i) = x(i) + 0.75*abs(x(i) - x_0(i));
                end
            end
        end
    end    
end