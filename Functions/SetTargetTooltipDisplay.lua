function SetTargetTooltipDisplay(hideTargetTooltip)
  if not hideTargetTooltip then return end

  hooksecurefunc('GameTooltip_SetDefaultAnchor', function(tooltip)
    tooltip:SetScript('OnTooltipSetUnit', function(self)
      local unit = select(2, self:GetUnit())
      if not unit then return end

      if AuraUtil.FindAuraByName("Flare", unit, "HARMFUL") then return end
      if AuraUtil.FindAuraByName("Cozy Fire", "player", "HELPFUL") then return end

      local _, total_str, _, _ = UnitStat("player", 1);
      local _, total_agi, _, _ = UnitStat("player", 2);
      local _, total_int, _, _ = UnitStat("player", 4);
      local lvl = UnitLevel(unit);

      -- Hide health bar graphic under tooltip
      if total_agi < 5 * lvl then
        GameTooltipStatusBar:Hide()
      end

      local name = GameTooltipTextLeft1;
      if total_int < 5 * lvl and not UnitIsPlayer(unit) and not UnitIsFriend("player", unit) then
        name:SetText(UnitCreatureType(unit))
      end

      -- Modify tooltip lines
      for i = 2, self:NumLines() do
        local line = _G['GameTooltipTextLeft' .. i]
        if line then
          local text = line:GetText()
          if text and not UnitIsPlayer(unit) then
            if total_str < 5 * lvl and text:match(LEVEL) and not UnitIsFriend("player", unit) then
              line:SetText('??')
            end
          end
        end
      end
    end)
  end)
end
