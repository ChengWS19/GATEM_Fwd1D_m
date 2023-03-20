function [times, outBt, outEt] = GATEM_Fwd1D(cmd)
    
    if cmd.numthreads<=0 || rem(cmd.numthreads,1)~=0
        disp('并行线程数非正整数，默认开启单线程')
        par_on(1)
    else
        par_on(cmd.numthreads)
    end

    times = cmd.t;
    recs=cmd.rec;
    
    parfor_progress(cmd.nrec);    
    parfor k=1:cmd.nrec
        rec=recs(k,:);
        Bt = zeros(length(times),3);
        Et = zeros(length(times),3);
        for i = 1: length(times)

            for j = 1: cmd.nsource

                src = cmd.src(j,:); 
                
                [B0,E0]= BFwdLine(cmd,src,rec,times(i));

                Bt(i,:) = Bt(i,:) + B0;
                Et(i,:) = Et(i,:) + E0;

            end

        end
        parfor_progress;
        outBt(:,:,k)=abs(Bt);
        outEt(:,:,k)=abs(Et);
    end
    parfor_progress(0);
    outBt = outBt * cmd.I0;
    outEt = outEt * cmd.I0;
    % reshape
    outBt = reshape (outBt,length(times),[]);
    outEt = reshape (outEt,length(times),[]);
end
