import { useBackend } from "../backend";
import { LabeledList, Section, Stack } from "../components";
import { Window } from "../layouts";

export const SepticShockCredits = (props, context) => {
  const { act, data } = useBackend(context);

  return (
    <Window
      title="Septic Shock Credits"
      width={450}
      height={700}
      theme="quake">
      <Window.Content>
        <Stack
          height="100%"
          overflowX="hidden"
          overflowY="scroll"
          vertical>
          <Stack.Item>
            <Section title="Developers">
              <LabeledList>
                <LabeledList.Item label="Matt">
                  Guy who updated this mess and continues to update it.
                </LabeledList.Item>
              </LabeledList>
            </Section>
            <Section title="Past Developers">
              <LabeledList>
                <LabeledList.Item label="Bomberman66">
                  Host, head coder, boss of this gym.
                </LabeledList.Item>
                <LabeledList.Item label="Eve">
                  Co-host, head spriter, touhou lover.
                </LabeledList.Item>
                <LabeledList.Item label="Remis12">
                  Co-host, lorebeard, coder, sounder.
                </LabeledList.Item>
                <LabeledList.Item label="Redrick">
                  Spriter, kindest man in SS.
                </LabeledList.Item>
                <LabeledList.Item label="Admiralwiseguy">
                  Spriter, somalian.
                </LabeledList.Item>
                <LabeledList.Item label="Schwick">
                  Spriter, Cruelty Squad enthusiast.
                </LabeledList.Item>
                <LabeledList.Item label="Spooky">
                  Spriter, tudo 2.
                </LabeledList.Item>
                <LabeledList.Item label="Infrared Baron">
                  Spriter, did most of the turfs, fallout enjoyer.
                </LabeledList.Item>
                <LabeledList.Item label="Lordkang45">
                  Writer, lore quality control, only guy in SS who reads books.
                </LabeledList.Item>
              </LabeledList>
            </Section>
          </Stack.Item>
          <Stack.Item>
            <Section title="Special thanks">
              <LabeledList>
                <LabeledList.Item label="/TG/ Station">
                  Providing a base for the code.
                </LabeledList.Item>
                <LabeledList.Item label="Goonstation">
                  Providing several sprites.
                </LabeledList.Item>
                <LabeledList.Item label="CEV Eris">
                  Providing several sprites.
                </LabeledList.Item>
                <LabeledList.Item label="Kapu">
                  For putting up with Matt&apos;s retardation.
                </LabeledList.Item>
                <LabeledList.Item label="Kas">
                  For believing.
                </LabeledList.Item>
                <LabeledList.Item label="Spooky">
                  For being there.
                </LabeledList.Item>
              </LabeledList>
            </Section>
          </Stack.Item>
          <Stack.Item>
            <Section
              title="Most special thanks..."
              style={{
                "font-size": "150%",
              }}>
              <LabeledList>
                <LabeledList.Item label="You">
                  For playing here!
                </LabeledList.Item>
              </LabeledList>
            </Section>
          </Stack.Item>
        </Stack>
      </Window.Content>
    </Window>
  );
};
