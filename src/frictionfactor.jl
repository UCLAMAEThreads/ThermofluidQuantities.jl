const RE_PIPE_LAMINAR = 2100
const RE_PIPE_TURBULENT = 4000

"""
    FrictionFactor(Re::ReynoldsNumber,ϵD::RoughnessRatio)

Return the Darcy friction factor for a pipe flow with the given
Reynolds number and roughness ratio. The function chooses the laminar
formula (f = 64/Re) if Reynolds number is smaller than 2100 and
uses the Colebrook equation if Reynolds number is larger than 4000.
For transitional Reynolds numbers it uses the laminar formula, but
warns the user.   
"""
function FrictionFactor(Re::ReynoldsNumber,ϵD::RoughnessRatio)
    _check_Re(Re)
    _check_roughness(ϵD)
    if _laminar(Re)
        return _f_laminar(Re)
    elseif _transitional(Re)
        @warn "Reynolds number is transitional. Using laminar relation."
        return _f_laminar(Re)
    elseif _turbulent(Re)
        return _f_turbulent(Re,ϵD)
    end
end

_f_laminar(Re::ReynoldsNumber) = FrictionFactor(64.0/Re)

function _f_turbulent(Re::ReynoldsNumber,ϵD::RoughnessRatio)
    err = 10.0
    fi = _f_haaland(Re,ϵD)
    f = fi
    while err > 1e-10
        f = _f_colebrook(Re,ϵD,fi)
        err = abs(f-fi)
        fi = f
    end
    f
end

function _f_colebrook(Re::ReynoldsNumber,ϵD::RoughnessRatio,f_in::FrictionFactor)
    _check_roughness(ϵD)
    t2 = Re == Inf ? 0.0 : 2.51/Re/sqrt(f_in)
    x = -2.0*log10(ϵD/3.7 + t2)
    return FrictionFactor(1.0/x^2)
end

function _f_haaland(Re::ReynoldsNumber,ϵD::RoughnessRatio)
    _check_roughness(ϵD)
    t2 = Re == Inf ? 0.0 : 6.9/Re
    x = -1.8*log10((ϵD/3.7)^1.11 + t2)
    return FrictionFactor(1.0/x^2)
end


_f_colebrook_fullyrough(ϵD::RoughnessRatio) = _f_colebrook(ReynoldsNumber(Inf),ϵD,FrictionFactor(Inf))

function _check_roughness(ϵD::RoughnessRatio)
    ϵD <= 0.05 || @warn "Roughness ratio is too large for Colebrook equation"
    ϵD >= 0.0 || throw(DomainError(ϵD,"Roughness ratio must be non-negative"))
    nothing
end

function _check_Re(Re::ReynoldsNumber)
    Re >= 0.0 || throw(DomainError(Re,"Reynolds number must be non-negative"))
    nothing
end

_laminar(Re::ReynoldsNumber) = Re <= RE_PIPE_LAMINAR

_transitional(Re::ReynoldsNumber) = (Re > RE_PIPE_LAMINAR && Re < RE_PIPE_TURBULENT)

_turbulent(Re::ReynoldsNumber) = Re >= RE_PIPE_TURBULENT
