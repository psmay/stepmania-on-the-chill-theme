
local SCALE_STAGE = 0.4
local SCALE_ANOTHER = 0.3
local SCALE_MODE = 0.4

local COLOR_NORMAL = ColorSchemeColors.FullyOn
local COLOR_HIGHLIGHT = ColorSchemeColors.Indicator
local COLOR_EXTRA = ColorSchemeColors.Extra

local NUMERAL_0 = Smotc.get_rendered_half_outline_text_path("numeral 0")
local NUMERAL_1 = Smotc.get_rendered_half_outline_text_path("numeral 1")
local NUMERAL_2 = Smotc.get_rendered_half_outline_text_path("numeral 2")
local NUMERAL_3 = Smotc.get_rendered_half_outline_text_path("numeral 3")
local NUMERAL_4 = Smotc.get_rendered_half_outline_text_path("numeral 4")
local NUMERAL_5 = Smotc.get_rendered_half_outline_text_path("numeral 5")
local NUMERAL_6 = Smotc.get_rendered_half_outline_text_path("numeral 6")
local NUMERAL_7 = Smotc.get_rendered_half_outline_text_path("numeral 7")
local NUMERAL_8 = Smotc.get_rendered_half_outline_text_path("numeral 8")
local NUMERAL_9 = Smotc.get_rendered_half_outline_text_path("numeral 9")

local WORD_ANOTHER = Smotc.get_rendered_text_path("word another")
local WORD_DEMO = Smotc.get_rendered_text_path("word demo")
local WORD_ENDLESS = Smotc.get_rendered_text_path("word endless")
local WORD_EVENT = Smotc.get_rendered_text_path("word event")
local WORD_EXTRA = Smotc.get_rendered_text_path("word extra")
local WORD_FINAL = Smotc.get_rendered_text_path("word final")
local WORD_MODE = Smotc.get_rendered_text_path("word mode")
local WORD_NONSTOP = Smotc.get_rendered_text_path("word nonstop")
local WORD_ONI = Smotc.get_rendered_text_path("word oni")
local WORD_STAGE = Smotc.get_rendered_text_path("word stage")

local metrics_table = {
  [1] = {
    metrics_for_stats = { x = 25, y = 105 },
    metrics_for_elements = {
      { from_left = false, actor_name = NUMERAL_1, x = 140, y = -45, zoom = 1.0 * 1.5 },
      { from_left = true, actor_name = WORD_STAGE, x = -58, y = -10, zoom = SCALE_STAGE, color = COLOR_HIGHLIGHT },
    },
  },
  [2] = {
    metrics_for_stats = { x = 17, y = 105 },
    metrics_for_elements = {
      { from_left = false, actor_name = NUMERAL_2, x = 160, y = -45, zoom = 1.5 },
      { from_left = true, actor_name = WORD_STAGE, x = -108, y = -10, zoom = SCALE_STAGE, color = COLOR_HIGHLIGHT },
    },
  },
  [3] = {
    metrics_for_stats = { x = 17, y = 105 },
    metrics_for_elements = {
      { from_left = false, actor_name = NUMERAL_3, x = 160, y = -45, zoom = 1.5 },
      { from_left = true, actor_name = WORD_STAGE, x = -108, y = -10, zoom = SCALE_STAGE, color = COLOR_HIGHLIGHT },
    },
  },
  [4] = {
    metrics_for_stats = { x = 195, y = 105 },
    metrics_for_elements = {
      { from_left = false, actor_name = NUMERAL_4, x = 160, y = -45, zoom = 1.5 },
      { from_left = true, actor_name = WORD_STAGE, x = -108, y = -10, zoom = SCALE_STAGE, color = COLOR_HIGHLIGHT },
    },
  },
  [5] = {
    metrics_for_stats = { x = 17, y = 105 },
    metrics_for_elements = {
      { from_left = false, actor_name = NUMERAL_5, x = 160, y = -45, zoom = 1.5 },
      { from_left = true, actor_name = WORD_STAGE, x = -108, y = -10, zoom = SCALE_STAGE, color = COLOR_HIGHLIGHT },
    },
  },
  [6] = {
    metrics_for_stats = { x = 17, y = 85 },
    metrics_for_elements = {
      { from_left = false, actor_name = NUMERAL_6, x = 160, y = -45, zoom = 1.5 },
      { from_left = true, actor_name = WORD_STAGE, x = -108, y = -10, zoom = SCALE_STAGE, color = COLOR_HIGHLIGHT },
    },
  },
  [7] = {
    metrics_for_stats = { x = 17, y = 120 },
    metrics_for_elements = {
      { from_left = false, actor_name = NUMERAL_7, x = 160, y = -45, zoom = 1.5 },
      { from_left = true, actor_name = WORD_STAGE, x = -108, y = -10, zoom = SCALE_STAGE, color = COLOR_HIGHLIGHT },
    },
  },
  [8] = {
    metrics_for_stats = { x = 17, y = 85 },
    metrics_for_elements = {
      { from_left = false, actor_name = NUMERAL_8, x = 160, y = -45, zoom = 1.5 },
      { from_left = true, actor_name = WORD_STAGE, x = -108, y = -10, zoom = SCALE_STAGE, color = COLOR_HIGHLIGHT },
    },
  },
  [9] = {
    metrics_for_stats = { x = 17, y = 105 },
    metrics_for_elements = {
      { from_left = false, actor_name = NUMERAL_9, x = 160, y = -45, zoom = 1.5 },
      { from_left = true, actor_name = WORD_STAGE, x = -108, y = -10, zoom = SCALE_STAGE, color = COLOR_HIGHLIGHT },
    },
  },
  Event = {
    metrics_for_stats = { x = 287, y = 100 },
    metrics_for_elements = {
      { from_left = true, actor_name = WORD_EVENT, x = 0, y = -28, zoom = 0.6 },
      { from_left = false, actor_name = WORD_MODE, x = 187.5, y = 55, zoom = 0.6 * SCALE_MODE, color = COLOR_HIGHLIGHT },
    },
  },
  Final = {
    metrics_for_stats = { x = 120, y = 114 },
    metrics_for_elements = {
      { from_left = true, actor_name = WORD_FINAL, x = 0, y = -44, zoom = 0.8 },
      { from_left = false, actor_name = WORD_STAGE, x = 111, y = 53, zoom = 0.8 * SCALE_STAGE, color = COLOR_HIGHLIGHT },
    },
  },
  Extra1 = {
    metrics_for_stats = { x = 162, y = 104 },
    metrics_for_elements = {
      { from_left = true, actor_name = WORD_EXTRA, x = 0, y = -38, zoom = 0.6, color = COLOR_EXTRA },
      { from_left = false, actor_name = WORD_STAGE, x = 155, y = 58, zoom = 0.6 * SCALE_STAGE, color = COLOR_HIGHLIGHT },
    },
  },
  Extra2 = {
    metrics_for_stats = { x = 162, y = 104 },
    metrics_for_elements = {
      { from_left = true, actor_name = WORD_EXTRA, x = 0, y = -38, zoom = 0.6, color = COLOR_EXTRA },
      { from_left = false, actor_name = WORD_STAGE, x = 155, y = 58, zoom = 0.6 * SCALE_STAGE, color = COLOR_HIGHLIGHT },
      { from_left = true, actor_name = WORD_ANOTHER, x = -153, y = -85, zoom = 0.6 * SCALE_ANOTHER },
    },
  },
  Endless = {
    metrics_for_stats = { x = 133, y = 58 },
    metrics_for_elements = {
      { from_left = true, actor_name = WORD_ENDLESS, x = 0, y = -24, zoom = 0.46 },
      { from_left = false, actor_name = WORD_MODE, x = 217, y = 46, zoom = 0.46 * SCALE_MODE, color = COLOR_HIGHLIGHT },
    },
  },
  Nonstop = {
    metrics_for_stats = { x = 135, y = 42 },
    metrics_for_elements = {
      { from_left = true, actor_name = WORD_NONSTOP, x = 0, y = -35, zoom = 0.42 },
      { from_left = false, actor_name = WORD_MODE, x = 215, y = 35, zoom = 0.42 * SCALE_MODE, color = COLOR_HIGHLIGHT },
    },
  },
  Oni = {
    metrics_for_stats = { x = 238, y = 108 },
    metrics_for_elements = {
      { from_left = true, actor_name = WORD_ONI, x = 0, y = -90, zoom = 1.0 },
      { from_left = false, actor_name = WORD_MODE, x = 72, y = 38, zoom = 1.0 * SCALE_MODE, color = COLOR_HIGHLIGHT },
    },
  },
  Demo = {
    metrics_for_stats = { x = 52, y = 80 },
    metrics_for_elements = {
      { from_left = true, actor_name = WORD_DEMO, x = 0, y = -41, zoom = 0.7 },
      { from_left = false, actor_name = WORD_MODE, x = 177, y = 61, zoom = 0.7 * SCALE_MODE, color = COLOR_HIGHLIGHT },
    },
  },
  _default = {
    metrics_for_stats = { x = (SCREEN_WIDTH * 0.5) - 24, y = (SCREEN_HEIGHT * -0.5) + 24 },
    metrics_for_elements = {},
  },
}

local sort_by_z_index
do
  local function nil_then_natural_compare(a, b)
    -- Augments natural ordering by having nil sort before all non-nil values
    if a == nil then
      return b == nil and 0 or -1
    elseif b == nil then
      return 1
    else
      return (a<b) and -1 or (a>b) and 1 or 0
    end
  end

  function sort_by_z_index(seq)
    return seq:sorted{
      by = function(v, i) return v.z_index end,
      compare = nil_then_natural_compare,
      stable = true
    }
  end
end

-- Assigns each element's timing values directly to the element.
local function schedule_delays(elements)
  local main_initial_delay = 0.3
  local main_staying_delay = 1.5
  local main_delay_increment = 0.1
  local main_transition_delay = 0.1

  local a, n = elements:to_array(true)

  local initial_delay = main_initial_delay
  for i=1,n do
    local v = a[i]
    v.transition_delay = main_transition_delay
    v.initial_delay = initial_delay
    initial_delay = initial_delay + main_delay_increment
  end

  local staying_delay = main_staying_delay
  for i=n,1,-1 do
    local v = a[i]
    v.staying_delay = staying_delay
    staying_delay = staying_delay + (2 * main_delay_increment)
  end

  return Sqib.from_array(a, n)
end

local function get_backdrop_element()
  local x1 = 0
  local x0 = x1 - SCREEN_WIDTH
  local y = 0
  local element = {
    actor = Def.ActorFrame {
      Def.Quad {
        InitCommand = function(self)
          self
            :zoomto(SCREEN_WIDTH, SCREEN_HEIGHT * 0.8)
            :diffuse(ColorSchemeColors.FullyOff)
            :diffusealpha(0.5)
        end
      }
    },
    x0 = x0,
    y0 = y,
    x1 = x1,
    y1 = y,
    zoom = 1
  }
  return element
end

local function get_stat_elements(stat_lines, x, y)
  local elements = stat_lines
    :map(
      function(text, i)
        local info_actor_y_offset = y
        local info_actor_y_offset_increment = 24

        local info_actor_y = info_actor_y_offset + ((i - 1) * info_actor_y_offset_increment)
        return {
          actor = Def.ActorFrame {
            LoadFont("Common Normal") .. {
              Text = text;
              InitCommand = function(self)
                self
                  :horizalign(right)
                  :vertalign(top)
              end
            }
          },
          x0 = x + -SCREEN_WIDTH,
          x1 = x,
          y0 = info_actor_y,
          y1 = info_actor_y,
          zoom = (i == 3) and 0.75 or 1,
          z_index = 10,
        }
      end
    )

  return elements
end

local function get_stat_lines(stage_info)
  local title_line_text = stage_info.title
  local course_type_or_artist_text = stage_info.is_course and stage_info.course_type or stage_info.artist
  local length_info_text = stage_info.length_info

  return Sqib.from({
    title_line_text,
    course_type_or_artist_text,
    length_info_text,
  })
end

local function get_custom_element(element_metrics)
  local x = element_metrics.x
  local y = element_metrics.y

  return {
    actor = LoadActor(element_metrics.actor_name),
    x0 = element_metrics.from_left and (x - SCREEN_WIDTH) or (x + SCREEN_WIDTH),
    y0 = y,
    x1 = x,
    y1 = y,
    zoom = element_metrics.zoom,
    z_index = element_metrics.z_index,
    color = element_metrics.color,
  }
end

local function determine_elements()
  local stage_info = Smotc.get_current_stage_info()

  local metrics_key = stage_info.is_numbered_stage and stage_info.number or stage_info.short_name

  local metrics_to_use = metrics_table[metrics_key]
  if metrics_to_use == nil then
    metrics_to_use = metrics_table._default
  end

  local backdrop_element = get_backdrop_element()

  local custom_elements = Sqib.from(metrics_to_use.metrics_for_elements)
    :map(get_custom_element)

  local stat_elements = get_stat_elements(
    get_stat_lines(stage_info),
    metrics_to_use.metrics_for_stats.x,
    metrics_to_use.metrics_for_stats.y
    )

  local elements = Sqib.from_all({backdrop_element}, custom_elements, stat_elements)

  return elements
end

local actors = determine_elements()
  :call(schedule_delays)
  :call(sort_by_z_index)
  :map(function(v)
    local color = v.color ~= nil and v.color or COLOR_NORMAL
    local zoom = v.zoom ~= nil and v.zoom or 1

    return v.actor .. {
      InitCommand = function(self)
        self
          :diffuse(color)
          :zoom(zoom)
          :diffusealpha(0)
          :sleep(v.initial_delay)
          :xy(v.x0, v.y0)
          :diffusealpha(1)
          :linear(v.transition_delay)
          :xy(v.x1, v.y1)
          :sleep(v.staying_delay)
          :linear(v.transition_delay)
          :xy(v.x0, v.y0)
          :diffusealpha(0)
      end
    }
  end)

local t = Def.ActorFrame {}

actors:copy_into_array(t, #t + 1)

return t;
