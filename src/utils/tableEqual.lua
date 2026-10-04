local function tableEqual(a, b)
    for key, val in pairs(a) do
        if b[key] ~= val then
            return false
        end
    end
    for key, val in pairs(b) do
        if a[key] ~= val then
            return false
        end
    end

    return true
end

return tableEqual
