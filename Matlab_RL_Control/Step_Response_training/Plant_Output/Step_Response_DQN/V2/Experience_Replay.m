classdef Experience_Replay < handle
    %EXPERIENCE_REPLAY 
    % A circular buffer
    properties
        buffer; % matrix array storing all of the experiences
        index = 1; % Current index of the latest insert
        overflow = 0; % Flag to determine whether the bugfer is full
        N; % Determines number of experiences stored
    end
    
    methods
        % Constructor to initialise the buffer memory (is faster)
        function obj = Experience_Replay()
            obj.N = 500000;
            obj.buffer = zeros(500000, 6);
            
        end
        
        % Inserts the latest experience into to buffer 
        function insert_experience(obj,S,A,R,Snew, Q_val)
            if obj.index > obj.N
                obj.index = 1;
                obj.overflow = 1;
            end
            obj.buffer(obj.index, 1:17) = [S(1), S(2), S(3), S(4), A, Snew(1), Snew(2), Snew(3), Snew(4), R, Q_val(1), Q_val(2), Q_val(3), Q_val(4), Q_val(5), Q_val(6), Q_val(7)];
            obj.index = obj.index+1;
        end
        
        % Samples a batch from the buffer with uniofrm random distribution
        function [Sold, A, R, Snew, Q_val] = get_batch(obj, batch_size)
            if ~obj.overflow
                rand_index = obj.index-1;
            else 
                rand_index = obj.N;
            end
            all_i = randi(rand_index, [batch_size, 1]);
            batch = obj.buffer(all_i, 1:17);
            Sold = batch(1:batch_size, 1:4);
            A = batch(1:batch_size, 5); 
            Snew = batch(1:batch_size, 6:9); 
            R = batch(1:batch_size, 10);
            Q_val = batch(1:batch_size, 11:17);
        end
    end
end

