function tauBounded = boundTourque(tau, limit)
    
    tauBounded=zeros(size(tau));
    
    for i=1:length(tau)
        if abs(tau(1,i))>=limit(1)
            tauBounded(1,i)=sign(tau(1,i))*limit(1);
        else
           tauBounded(1,i)=tau(1,i);
        end
        
        if abs(tau(2,i))>=limit(2)
            tauBounded(2,i)=sign(tau(2,i))*limit(2);
        else
            tauBounded(2,i)=tau(2,i);
        end
    end
    
    
end