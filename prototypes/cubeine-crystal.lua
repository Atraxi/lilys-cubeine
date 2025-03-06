local item_sounds = require("__base__.prototypes.item_sounds")
local space_age_item_sounds = require("__space-age__.prototypes.item_sounds")
local sounds = require("__base__.prototypes.entity.sounds")

local effect_duration = 60 * 60
local wd_duration = 300 * 60
local wd_speed = 0.2
local boost = 5
local dps = 100

local item = {

    type = "capsule",
    name = "cubeine-crystal",
    icon = "__lilys-cubeine__/graphics/icons/cubeine-crystal.png",
    subgroup = "cubeine-processes",
    order = "b[agriculture]-g[cubeine-crystal]",
    inventory_move_sound = space_age_item_sounds.ice_inventory_move,
    pick_sound = space_age_item_sounds.ice,
    drop_sound = space_age_item_sounds.ice_inventory_move,
    stack_size = 100,
    default_import_location = "nauvis",
    weight = 50,
    fuel_category = "chemical",
    fuel_value = "10MJ",
    fuel_acceleration_multiplier = 20,
    fuel_top_speed_multiplier = 5,
    fuel_emissions_multiplier = 100,
    capsule_action = {
        type = "use-on-self",
        attack_parameters =
        {
            type = "projectile",
            activation_type = "consume",
            ammo_category = "capsule",
            cooldown = 60 * 4,
            range = 0,
            ammo_type =
            {
                target_type = "position",
                action =
                {
                    type = "direct",
                    action_delivery =
                    {
                        {
                            type = "instant",
                            target_effects =
                            {
                                {
                                    type = "create-sticker",
                                    sticker = "cubeine-crystal-sticker",
                                    show_in_tooltip = true
                                },
                                {
                                    type = "create-sticker",
                                    sticker = "cubeine-crystal-sticker-2",
                                },
                                {
                                    type = "play-sound",
                                    sound = sounds.eat_fish,
                                },
                                {
                                    type = "script",
                                    effect_id = "cubeine-crystal-consumed"
                                }
                            }
                        },
                        {
                            type = "delayed",
                            delayed_trigger = "cubeinecrystal-wd"
                        }
                    }
                }
            }
        }
    }
}

local sticker1 = {
    type = "sticker",
    name = "cubeine-crystal-sticker",
    flags = { "not-on-map" },
    hidden = true,
    single_particle = true,
    duration_in_ticks = effect_duration,
    target_movement_modifier = boost,
    damage_interval = 15,
    damage_per_tick = { amount = dps / 4, type = "poison" },
    animation =
        util.sprite_load("__lilys-cubeine__/graphics/sticker/whirl_front",
            {
                priority = "high",
                frame_count = 50,
                scale = 0.5,
                animation_speed = 3,
                shift = util.by_pixel(0, 16),
                tint = { 1, 0, 0, 1 },
                draw_as_glow = true
            }
        )
}
local sticker2 = {
    type = "sticker",
    name = "cubeine-crystal-sticker-2",
    flags = { "not-on-map" },
    hidden = true,
    single_particle = true,
    duration_in_ticks = effect_duration,
    render_layer = "object-under",
    animation =
        util.sprite_load("__lilys-cubeine__/graphics/sticker/whirl_back",
            {
                priority = "high",
                frame_count = 50,
                scale = 0.5,
                animation_speed = 3,
                shift = util.by_pixel(0, 16),
                tint = { 1, 0, 0, 1 },
                draw_as_glow = true
            }
        )
}

local sticker3 = {
    type = "sticker",
    name = "cubeine-crystal-sticker-3",
    flags = { "not-on-map" },
    hidden = true,
    single_particle = true,
    duration_in_ticks = wd_duration,
    target_movement_modifier = wd_speed,
    target_movement_modifier_to = 1,
    ground_target = true
}


local delayed_trigger = {
    type = "delayed-active-trigger",
    name = "cubeinecrystal-wd",
    delay = effect_duration,
    action = {
        type = "direct",
        action_delivery = {
            type = "instant",
            source_effects = {
                {
                    type = "create-sticker",
                    sticker = "cubeine-powder-sticker-3",
                },
            }
        }

    }
}

data:extend { item, sticker1, sticker2, sticker3, delayed_trigger }
