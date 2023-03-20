function []=par_on(numthreads)
    %% 输入变量检查
    narginchk(1,1);
    %% 并行线程数 和 运行总循环数
    NThreads = maxNumCompThreads; % 获取本机最大线程数
    %% 并行线程数判断
    % 防止每次开关并行处理，节省时间
    par=gcp('nocreate');
    if isempty(par)        
        if numthreads>NThreads            
            disp(['输入线程数',num2str(numthreads),...
                '超过机器最大线程数',num2str(NThreads),'默认全部启用'])
            parpool(NThreads);
        else
            disp(['本次计算开启',num2str(numthreads),'并行线程'])
            parpool(numthreads);
        end
    else        
        poolsize=par.NumWorkers;
        disp(['并行',num2str(poolsize),'线程已经开启'])
    end 
end


